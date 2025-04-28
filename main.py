import os
import glob
import requests
import simplekml


class Config:
    OVERPASS_URL = "https://overpass-api.de/api/interpreter"
    TEMPLATES_DIR = "templates"
    OUTPUT_DIR = "kml_outputs"


def ensure_dir(path):
    print(f"Checking if path '{path}' exists")
    if not os.path.exists(path):
        print(f"Path '{path}' does not exist, creating it")
        os.makedirs(path)
    print(f"Path '{path}' exists, all good")


def fetch_osm_json(query: str) -> dict:
    """Fetches OSM data for a given query as JSON.

    Args:
        query: Overpass query string.

    Returns:
        A JSON-formatted dict as returned by the Overpass API.
    """
    print(f"Fetching OSM data for query:\n{query}")
    response = requests.post(Config.OVERPASS_URL, data={'data': query})
    print(f"Received response from Overpass API")
    response.raise_for_status()
    print("Response code was 200")
    return response.json()


def json_to_kml(osm_data: dict, out_path: str):
    kml = simplekml.Kml()
    try:
        elements = osm_data.get('elements', [])
        for element in elements:
            element_type = element.get('type', 'unknown')
            element_id = element.get('id', 'unknown')
            print(f"Processing {element_type} {element_id}")
            
            tags = element.get('tags', {})
            coords = []

            if element_type == 'node':
                lon = element.get('lon')
                lat = element.get('lat')
                if lon is None or lat is None:
                    print(f"Skipping node {element_id} with missing coordinates")
                    continue
                coords = [(lon, lat)]
            elif 'geometry' in element:
                coords = [
                    (pt.get('lon'), pt.get('lat'))
                    for pt in element.get('geometry', [])
                    if pt.get('lon') is not None and pt.get('lat') is not None
                ]

            if not coords:
                print(f"Skipping {element_type} {element_id} with no coordinates")
                continue

            print(f"Found {len(coords)} coordinates for {element_type} {element_id}")

            name = tags.get('name', element_type)
            desc = "\n".join(f"{k}: {v}" for k, v in tags.items())

            if element_type == 'node':
                p = kml.newpoint(name=name, coords=coords)
            else:
                p = kml.newpolygon(name=name, outerboundaryis=coords)
            p.description = desc

        print(f"Saving KML to {out_path}")
        kml.save(out_path)
    except Exception as e:
        print(f"Error processing OSM data: {str(e)}")

def main():
    ensure_dir(Config.OUTPUT_DIR)

    # Prompt for country once (or hardcode)
    country = input("Enter COUNTRY_CODE (e.g. TR): ")
    if not country:
        print("Country code cannot be empty.")
        return

    # Iterate all template files
    tpl_paths = glob.glob(os.path.join(Config.TEMPLATES_DIR, "*.tpl"))
    if not tpl_paths:
        print("No template files found in the templates dir.")
        return
    for tpl_path in tpl_paths:
        tpl_name = os.path.splitext(os.path.basename(tpl_path))[0]
        print(f"Processing {tpl_name}...")
        try:
            with open(tpl_path, 'r', encoding='utf-8') as f:
                template = f.read()
        except Exception as e:
            print(f"Error reading template {tpl_name}: {e}")
            continue

        # Format query with the chosen country
        query = template.replace("{country}", country)

        print(f"Query: {query}")
        print(f"Fetching '{tpl_name}' for {country}...")
        try:
            osm_data = fetch_osm_json(query)
        except Exception as e:
            print(f"Error fetching data for {tpl_name} in {country}: {e}")
            continue

        # Save to KML
        out_file = os.path.join(Config.OUTPUT_DIR, f"{country}_{tpl_name}.kml")
        print(f"Saving to {out_file}...")
        try:
            json_to_kml(osm_data, out_file)
        except Exception as e:
            print(f"Error saving KML for {tpl_name} in {country}: {e}")
            continue
        print(f"Saved: {out_file}")

if __name__ == "__main__":
    main()



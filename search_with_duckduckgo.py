# required: pip install duckduckgo_search

import argparse
from duckduckgo_search import DDGS

def google_search(query, sites, num_results=1):
    # Create the search query with site restrictions
    site_query = ' OR '.join([f'site:{site}' for site in sites])
    full_query = f'{query} {site_query}'

    # Perform the search
    search_results = DDGS().text(full_query, max_results=num_results)

    # Return the first result
    return search_results[0]['href']

if __name__ == "__main__":
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Search Google for a term on specific sites and return the first result.")
    parser.add_argument("query", type=str, help="The search query term.")

    # Parse the arguments
    args = parser.parse_args()

    # Define the list of sites to search within
    sites = ["python.org",
             "numpy.org",
             "matplotlib.org",
             "scipy.org",
             "sympy.org",
             "scikit-image.org",
             "pandas.pydata.org",
             "bokeh.org",
             "holoviews.org"
             ]

    # Get the first search result
    first_result = google_search(args.query, sites)

    if first_result:
        print(first_result)
    else:
        print("No results found.")

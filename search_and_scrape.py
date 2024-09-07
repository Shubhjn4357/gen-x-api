# search_and_scrape.py

from googlesearch import search
import requests
from bs4 import BeautifulSoup

def search_and_scrape(query, num_results=3):
    results = []
    for url in search(query, num_results=num_results):
        print(f"Scraping URL: {url}")
        try:
            response = requests.get(url)
            soup = BeautifulSoup(response.text, 'html.parser')
            paragraphs = [p.get_text() for p in soup.find_all('p')]
            content = ' '.join(paragraphs)
            results.append(content)
        except Exception as e:
            print(f"Error scraping {url}: {e}")
    return results

---
---

window.SimpleJekyllSearch({
  searchInput: document.getElementById('search-input'),
  resultsContainer: document.getElementById('results-container'),
  json: '{{ "/search.json" | relative_url }}',
  searchResultTemplate: '<li><a href="{url}">{title}</a></li>',
  noResultsText: 'No results found',
});

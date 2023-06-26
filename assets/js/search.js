// Wait for the DOM to be ready
document.addEventListener("DOMContentLoaded", function() {
  // Initialize Lunr.js and create a search index
  var idx;
  lunr(function() {
    this.field('title');
    this.field('content');
    this.ref('url');
    idx = this; // Assign the index to the outer variable

    // Fetch the search data from the search.json file
    fetch("../../search.json")
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        // Add the data to the search index
        data.forEach(function(page) {
          if (Object.keys(page).length > 0) {
            idx.add(page);
          }
        });
      })
      .catch(function(error) {
        console.log("Error fetching search data:", error);
      });
  });

  // Perform the search when the user submits the form
  document.getElementById("search-form").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent form submission

    var searchInput = document.getElementById("search-input");
    var searchResults = document.getElementById("search-results");

    var searchQuery = searchInput.value.trim(); // Get the search query

    console.log("Search Query:", searchQuery); // Print the search query

    // Check if the index is populated before performing the search
    if (idx) {
      // Perform the search using Lunr.js
      var results = idx.search(searchQuery);

      console.log("Here are the search results:", results);

      // Display the search results
      searchResults.innerHTML = ""; // Clear previous results

      if (results.length > 0) {
        // Loop through the search results and display them
        for (var i = 0; i < results.length; i++) {
          var result = results[i];
          var resultPage = result.ref;
          var resultTitle = result.doc.title;

          // Create a link to the search result page
          var link = document.createElement("a");
          link.href = resultPage;
          link.textContent = resultTitle;

          // Append the link to the search results element
          searchResults.appendChild(link);
        }
      } else {
        // Display a message if no results were found
        var message = document.createElement("p");
        message.textContent = "No results found.";
        searchResults.appendChild(message);
      }
    } else {
      console.log("Index is not ready yet. Please wait and try again.");
    }
  });
});

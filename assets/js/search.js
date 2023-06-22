// Wait for the DOM to be ready
document.addEventListener("DOMContentLoaded", function() {
  // Initialize Lunr.js and create a search index
  var index = lunr(function() {
    this.field("title");
    this.field("content");
    this.ref("url");

    var lunrIndex = this; // Reference to the Lunr index object

    // Fetch the search data from the search.json file
    fetch("../../search.json")
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        // Add the data to the search index
        data.forEach(function(page) {
          if (Object.keys(page).length > 0) {
            lunrIndex.add(page);
          }
        });
      })
      .catch(function(error) {
        console.log("Error fetching search data:", error);
      });
  });

  // Get references to the search input and search results elements
  var searchInput = document.getElementById("search-input");
  var searchResults = document.getElementById("search-results");

  // Perform the search when the user submits the form
  document.getElementById("search-form").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent form submission

    var query = searchInput.value.trim(); // Get the search query

    console.log("Search Query:", query); // Print the search query

    // Perform the search using Lunr.js
    try {
      var results = index.search(query, {
        fields: {
          title: { boost: 10 },
          content: { boost: 1 }
        }
      });

      // Display the search results
      searchResults.innerHTML = ""; // Clear previous results

      if (results.length > 0) {
        // Loop through the search results and display them
        for (var i = 0; i < results.length; i++) {
          var result = results[i];
          var page = result.ref;
          var title = result.doc.title;

          // Create a link to the search result page
          var link = document.createElement("a");
          link.href = page;
          link.textContent = title;

          // Append the link to the search results element
          searchResults.appendChild(link);
        }
      } else {
        // Display a message if no results were found
        var message = document.createElement("p");
        message.textContent = "No results found.";
        searchResults.appendChild(message);
      }
    } catch (error) {
      console.log("Error performing search:", error);
      // Display an error message to the user or handle the error in another way
    }
  });
});

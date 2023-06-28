// Wait for the DOM to be ready
document.addEventListener("DOMContentLoaded", function () {
  (async function () {
    var idx;
    var data;

    // Declare pageData here to store the pages' data
    var pageData = {};

    try {
      // Fetch the search data from the search.json file
      var response = await fetch("../../search.json");
      data = await response.json();
    } catch (error) {
      console.log("Error fetching search data:", error);
    }

    // Initialize Lunr.js and create a search index
    idx = lunr(function () {
      this.field("title");
      this.field("content");
      this.ref("url");

      // Add the data to the search index
      data.forEach(function (page) {
        if (page.url && page.title && page.content) {
          this.add(page);
          // Store the page data for later use
          pageData[page.url] = page;
        }
      }, this);
    });

    console.log("This is the idx object after config function:", idx);

    // Perform the search when the user submits the form
    document
      .getElementById("search-form")
      .addEventListener("submit", function (event) {
        event.preventDefault(); // Prevent form submission

        var searchInput = document.getElementById("search-input");
        var searchResults = document.getElementById("search-results");

        var searchQuery = searchInput.value.trim(); // Get the search query

        console.log("Search Query:", searchQuery); // Print the search query

        // Clear the search results
        searchResults.innerHTML = "";

        if (searchQuery) {
          // Display the search term
          searchResults.innerHTML =
            "<p>Search results for '" + searchQuery + "':</p>";

          // Perform the search using Lunr.js
          var results = idx.search(searchQuery);

          if (results.length > 0) {
            // Loop through the search results and display them
            for (var i = 0; i < results.length; i++) {
              var result = results[i];
              var resultPage = pageData[result.ref]; // Look up the page data
              var url = resultPage.url;
              var title = resultPage.title;
              var content = resultPage.content.substring(0, 160) + "...";

              // Append the search result as a new paragraph
              searchResults.innerHTML +=
                "<p class='search-result'><a href='" +
                url +
                "'><span class='title'>" +
                title +
                "</span><br /><span class='content'>" +
                content +
                "</span><br /><span class='url'>" +
                url +
                "</span></a></p>";
            }
          } else {
            // Display a message if no results were found
            searchResults.innerHTML +=
              "<p class='search-result'>No results found...</p>";
          }
        }
      });
  })();
});
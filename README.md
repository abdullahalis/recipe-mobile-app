# recipe-mobile-app

### Summary: 

https://github.com/user-attachments/assets/60ffa7c6-a2c0-4f84-9b63-9701ed26fd41

### Focus Areas: 
I focused on adhering to MVVM principles and modularizing code so that the models and views are agnostic of each other, allowing reusability and easier testing. I also focused on error handling and making sure optional types and bad data didn't negatively impact the user experience. Efficiency in networking and data fetching were also prioritized so I implemented an LRU cache to store reusable image data. 

### Time Spent: 
I spent around 10 hours on this project. I first planned how I wanted to architect the app and what objects and models I would need to create. Then I started with the backend data fetching, testing as I went to make sure everything worked as expected. I moved on to a simple UI, first creating dummy data to be displayed, and creating seperate views for different sections. Once I had a functional app that was properly displaying data from the API and had good error handling, I moved on to implementing a cache to make the networking for efficient and reduce repeated work. Finally, I wrote complete tests to assess performance and check edge cases.

### Trade-offs and Decisions:
- LRU Cache simplicity vs performance
  - To reduce API usage, I implemented a local image cache with a hashmap and doubly linked list for O(1) reads, writes, and LRU reordering.
  - This added some memory overhead, especially if you're caching every image, so I added a max capacity to keep the memory usage in check
  - I used NSLock for thread safety because I was running into problems when multiple threads accessed the cache conccurently. While this prevents race conditions, it might not scale well with too many threads, but it works perfectly for a small project like this. I priorited clarity over fine-tuned performance.
 
- Youtube Video Link vs Embed
  - I decided to embed the Youtube videos within the application, rather than linking to the video as a URL
  - I wanted to make the app more wholistic and not make the user leave the app when possible.
  - The loading of the video does take sometime however, which could be bad for the user experience, but I think having embedded videos is worth the tradeoff and looks nicer.
  - One solution could involve caching the videos so if the user comes back to a recipe the video is loaded much quicker

### Weakest Part of the Project:
- I think the weakest part of the project is the User Interface. It's very simple and doesn't have a ton of features. To improve it, I would add a save recipes feature and use another API or a light LLM model to get short descriptions of recipes to put in the detail view.

- The cache I made may be another weak point. This was my first time making my own cache from scratch, so it's quite barebones and could be improved with better concurrency handling.

### Additional Information:
- The embedded Youtube player can cause issues when the video URL from the API no longer exists. The fix for this that I found was using 3rd party Youtube libraries that can provide data on whether the video is still available, but that would go against the requirements.

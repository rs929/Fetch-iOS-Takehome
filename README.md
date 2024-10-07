# Steps to Run the App
1. Clone the Repository: Start by cloning the project repository from GitHub.
2. Open in Xcode: Open the project in Xcode.
3. Install Package Dependencies: This app utilizes Kingfisher 8.0.3 as a package through SPM, make sure dependencies are properly installed.

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

The specific part of the project I chose to proritize was the backend API integration with the GET endpoint to fetch all recipes. I think I chose to prioritize this as my first task because a lot of the UI that I needed to implement later on is heavily dependent on how the data is stored in the backend API such as: what the model looks like, what needs to be displayed, what properties are optional, etc. Another aspect I chose to focus on was using SwiftUI's state management effectively to handle user interactions smoothly and to ensure that the app was responsive to state changes. I think that these areas are important to prioritize as the architecture and structure of your views is dependent on how these are setup, so its better to have a clearer picture of the backend integration and the state management before starting any significant UI implementation.

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent around 5 hours overall on this task split over 2 days. Here is a rough timeline on how I allocated my time:

Saturday 10/05 - Setup the repository and the project folder structure, including folder groups and base view (~30 mins)
Sunday 10/06 - Implemented NetworkManager Functions and testing with backend GET API request to figure out model setup and optional properties (~30 minutes)
Sunday 10/06  - Setup Models based on the GET request structure (<5 minutes)
Sunday 10/06 - Setup Keys and Constants files to allow for reuse of UI elements and abstraction of endpoint URL (<5 minutes)
Sunday 10/06 - Figuring out serial image loading and caching with Kingfisher and small + large image (~30 minutes)
Sunday 10/06 - Implementing reusable components, views, viewModels, and integrating functions written in NetworkManager. (~2 hours)
Sunday 10/06 - Writing unit tests for viewModel functions (~30 minutes)
 

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

A trade-off I decided to make for the sake of time was the filtering logic to where I did not allow for search and filtering to interact with each other. In my implementation you are only able to search by name/cuisine, or filter with the buttons. By preventing these two interactions from happening at the same time, I did not need to spend the time to figure out the logic of how they would interact. Another trade-off I considered was the use of the 3rd-party package Kingfisher to deal with image caching, since this saves a lot of time because I don't have to implement a custom image cache, but at the same time reduces the customizability I have within my app.

# Weakest Part of the Project: What do you think is the weakest part of your project?

I think the weakest part of the project that was the largest learning curve for me was figuing out the logic for the image loading to where you would first display a placeholder view, then the smaller image, and then display the larger image once it finished downloading. I ended up brainstoring for a long time, but ended up creating a custom component for this, but I am unsure if my implementation was the best practice or most efficient implementation of this loading behavior.

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I only used 1 3rd party dependency which was Kingfisher 8.0.3 which I installed using SwiftPackageManager

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

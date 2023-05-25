# MiniPokedex

MiniPokedex is a simple iOS app built with SwiftUI that allows users to explore and view information about different Pokémon. It provides a minimalistic user interface with features such as displaying random Pokémon, bookmarking favorites, managing selected Pokémon, and accessing detailed views.

## Features

- Random Pokémon: Users can tap the "Next" button to fetch and display information about a random Pokémon, including its name, image, type, and stats.
- Bookmarking: Users can bookmark their favorite Pokémon by tapping the heart icon. Bookmarked Pokémon will be stored for future reference.
- Selection: Users can select and unselect Pokémon by tapping the "Select" or "Unselect" button. This feature allows users to keep track of their chosen Pokémon.
- Detailed Views: Tapping on a row in the "Bookmarked" list or the "Selected" menu item opens a detailed view of the Pokémon. The view displays the Pokémon's name, image, type, and stats. Users can unbookmark the Pokémon and toggle its selection status.
- Tab Navigation: The app utilizes a tab bar interface, providing separate tabs for displaying the selected Pokémon, browsing bookmarked Pokémon, and accessing the settings.
- Parent and Kid Modes: The app offers two modes: "Parent" and "Kid." The "Parent" mode is intended for parents to use, while the "Kid" mode is designed for children.
- Parent View: In the "Parent" view, a random Pokémon is shown along with information such as its image, type, and statistics. Users can tap the "Next" button to fetch a new random Pokémon.
- Bookmarking Pokémon: In the "Parent" view, users can tap the heart icon at the top right to bookmark the displayed Pokémon. This allows them to save it for later or view it in the "Bookmarked" list.
- Selecting Pokémon: In the "Parent" view, users can tap the "Select" button to mark the Pokémon as selected. Only one Pokémon can be selected at a time.
- Side Menu: Tapping the icon at the top left of the "Parent" view opens a side menu from the left. It displays two menu items: "Bookmarked" and "Selected."
- Bookmarked Pokémon List: In the side menu, users can tap "Bookmarked" to view a list of all bookmarked Pokémon, including their icons and names. Tapping on a row in the list opens a detailed view of the Pokémon.
- Removing All Bookmarks: In the "Bookmarked" list view, users can tap the icon at the top right to remove all their bookmarks at once.
- Selected Pokémon View: In the side menu, users can tap "Selected" to open a view that displays the currently selected Pokémon (if any). The view shows the Pokémon's name, image, type, and stats. Users can unselect the Pokémon and bookmark it.
- Kid View: In the "Kid" view, only the selected Pokémon is visible. Tapping the "Kid" item in the bottom menu takes the user to this view.

## Usage

1. Clone the repository or download the source code.
2. Open the project in Xcode by double-clicking the MiniPokedex.xcodeproj file.
3. Ensure that the target device or simulator is selected in Xcode's scheme menu.
4. Press the "Run" button or use the shortcut Cmd+R to build and run the app.
5. In the app, tap on the "Parent" item in the bottom menu to explore and view random Pokémon.
6. A random Pokémon will be displayed with its name, image, type, and statistics.
7. Tap the "Next" button to fetch a new random Pokémon.
8. To bookmark a Pokémon, tap the heart icon at the top right corner of the view. Tap it again to remove the bookmark.
9. To select a Pokémon, tap the "Select" button. Only one Pokémon can be selected at a time.
10. Access the side menu by tapping the icon at the top left of the "Parent" view.
11. From the side menu, select the "Bookmarked" item to view a list of bookmarked Pokémon. Tap a row to see more details and the option to unbookmark the Pokémon.
12. In the "Bookmarked" list view, you can also find a clear icon at the top right corner to remove all bookmarks at once.
13. In the side menu, select the "Selected" item to view the currently selected Pokémon. This view displays its name, image, type, and stats.
14. From the "Selected" view, you can unselect the Pokémon or bookmark it.
15. To view the selected Pokémon in "Kid" mode, tap on the "Kid" item in the bottom menu.

## Installation

To run the MiniPokedex app on your iOS device or simulator, follow these steps:

1. Clone the repository or download the source code.
2. Open the project in Xcode by double-clicking the `MiniPokedex.xcodeproj` file.
3. Ensure that the target device or simulator is selected in Xcode's scheme menu.
4. Press the "Run" button or use the shortcut Cmd+R to build and run the app.

## Requirements

- Xcode 12 or later
- iOS 14.0 or later

## Future Enhancements

The MiniPokedex app provides a solid foundation for exploring and managing Pokémon. Here are some potential enhancements that could be implemented in future iterations:

- Search Functionality: Allow users to search for specific Pokémon by name or type.
- Filtering and Sorting: Provide options for filtering and sorting Pokémon based on various criteria.
- Additional Pokémon Details: Expand the detailed view to include more information about each Pokémon, such as abilities, moves, and evolution chains.
- User Accounts: Implement user accounts to enable personalization, synchronization across devices, and the ability to share Pokémon with other users.
- Offline Mode: Add offline support, allowing users to access previously fetched Pokémon data even without an internet connection.
- Customization Options: Allow users to customize the app's appearance, such as choosing different themes or Pokémon artwork styles.

Enjoy exploring and managing Pokémon with MiniPokedex!

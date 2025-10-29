🛫 SkySearch - Flutter Flight Search UI
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e794883e-3cd6-4ca7-b052-bbe974b18904" width="250" alt="Home Screen"/></td>
    <td><img src="https://github.com/user-attachments/assets/b1159ba3-1af3-45e9-b679-0e352b60666d" width="250" alt="Airport Search"/></td>
    <td><img src="https://github.com/user-attachments/assets/1debf324-0897-41dc-8921-49c7a52453ea" width="250" alt="Date Pick"/></td>
  </tr>
  <tr>
    <td align="center"><b>Home Screen</b></td>
    <td align="center"><b>Airport Search</b></td>
    <td align="center"><b>Date Pick</b></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/40038bc9-6935-4445-8380-765b41966d33" width="250" alt="Passenger Select"/></td>
    <td><img src="https://github.com/user-attachments/assets/c883b623-66ec-4f9b-9ce1-16db12cde205" width="250" alt="Search Details"/></td>
  </tr>
  <tr>
    <td align="center"><b>Passenger Select</b></td>
    <td align="center"><b>Search Details</b></td>
  </tr>
</table>







A sleek and modern Flutter application for searching flights with a beautiful airline-style interface. Built with BLoC pattern for robust state management and clean architecture principles.

🎯 Perfect for: Portfolio projects, Flutter interviews, learning BLoC pattern, or as a foundation for a real flight booking app.


✨ Features
🌍 Smart Airport Selection

✅ Fetches live airport data from JSON API (3000+ airports)
✅ Real-time search with instant filtering
✅ Search by city, airport name, IATA code, or country
✅ Beautiful UI with airport icons and detailed info
✅ Optimized search using search_contents field

🔄 Quick Swap Functionality

✅ One-tap swap between origin and destination
✅ Smooth animations and transitions
✅ Intelligent validation to prevent same airport selection

📅 Departure Date Picker

✅ Material Design date picker
✅ Only allows future dates
✅ Custom theme matching app colors
✅ Format: DD MMM YYYY (e.g., 29 Oct 2025)

👥 Passenger Counter

✅ Beautiful bottom sheet modal
✅ Increment/decrement buttons with haptic feedback
✅ Range: 1-9 passengers
✅ Smooth animations and user feedback

🔍 Search & Validation

✅ Complete form validation
✅ User-friendly error messages
✅ Search results displayed in dialog
✅ Console logging for debugging


📖 How to Use
User Flow

🏠 Launch app → View gradient header with SkySearch branding
🛫 Select origin → Tap "From" → Search for departure airport
🛬 Select destination → Tap "To" → Choose arrival airport
🔄 Swap (optional) → Use swap button to exchange airports
📅 Pick date → Select departure date from calendar
👥 Choose passengers → Adjust passenger count (1-9)
🔍 Search → View flight search summary

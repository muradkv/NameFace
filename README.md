# NameFace

![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.0+-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-147EFB?logo=xcode&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Persistence](https://img.shields.io/badge/Persistence-FileManager_+_JSON-FFD700)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-8A2BE2)

NameFace solves the problem of forgetting names after meeting new people at conferences or meetups. The app allows users to import photos from their library, attach names to them, and maintain a searchable contact collection stored entirely on-device.

## Preview

<img width="23%" alt="Empty" src="https://github.com/user-attachments/assets/2e2aeac2-18e3-43d9-9732-9a6e8ad99b90" />
<img width="23%" alt="List" src="https://github.com/user-attachments/assets/f3490c8e-8404-4403-a886-9cab1c0e26fc" />
<img width="23%" alt="Detail" src="https://github.com/user-attachments/assets/b3d5db3f-d9b1-4fdc-9218-e17c05cb9c53" />
<img width="23%" alt="Add" src="https://github.com/user-attachments/assets/3f3ae3c6-2ac8-4171-b231-f74e440ba204" />

## Features

- **Photo Import:** Uses SwiftUI's `PhotosPicker` to let users select images from their photo library with native iOS integration.
- **Immediate Naming Flow:** Detects when a new photo is imported and immediately presents a modal sheet for attaching a name.
- **Dual Storage System:** Separates image files from structured data — photos stored in documents directory via `FileManager`, person records persisted as JSON.
- **Alphabetically Sorted List:** Displays saved contacts in a sorted list for easy navigation using `Comparable` conformance on the `Person` model.
- **Full-Size Detail View:** Dedicated detail screen showing selected person's photo at full resolution.
- **Error Handling:** Presents user-friendly alerts when photo importing or local data persistence fails via `do-catch` blocks.

## About the Project & Challenge

This application was built as the consolidation milestone spanning **Day 77 Challenge (Milestone: Projects 13-15)** of Paul Hudson's 100 Days of SwiftUI course. The challenge required combining photo selection, user input, local persistence, and navigation into a complete personal contact management workflow.

Key architectural practices implemented in this repository include:

- **Observation Framework State Management:** Utilized `@Observable`, `@State`, and `@Bindable` for modern state management with automatic dependency tracking across the app.
- **MVVM Architecture:** Completely separated concerns into pure SwiftUI views (`Views/`), `@Observable` view models (`PeopleViewModel`), a dedicated file I/O service (`StorageService`), and a `Comparable`-conforming domain model (`Person`).
- **Asynchronous Image Loading:** Used `PhotosPickerItem.loadTransferable(type:)` with Swift concurrency (`async/await`) to ensure smooth UI performance during photo selection.
- **Dual Persistence Strategy:** Chose `FileManager` + JSON over SwiftData for this implementation, storing large image files externally while maintaining lightweight JSON metadata — giving direct control over file naming and explicit serialization.
- **Separation of Responsibilities:** Encapsulated all disk operations in `StorageService`, keeping the ViewModel free of file I/O concerns and the views purely declarative.

🔗 **[Challenge description (Day 77)](https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge)**

## Project Versioning & Changelog

* **v1.0.0 (NameFace MVP)** — `commit: 4ff9197` <br>
  Initial release completing the Day 77 challenge. Implemented `PhotosPicker` import, immediate naming flow via `AddPersonView`, dual persistence with `StorageService` (FileManager for images, JSON for records), alphabetically sorted list driven by `Comparable` `Person` model, and navigation to full-size `PersonDetailView`.

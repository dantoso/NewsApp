# News App

This is a simple app made as part of a 7 day challenge. The app consumes the _newsapi.org_ and displays part of its content in a home screen and an article screen, both being beautifully designed and animated.

<img width="408" alt="Captura de Tela 2024-05-15 às 23 32 45" src="https://github.com/dantoso/NewsApp/assets/80010223/4a934200-18dc-40d1-8359-84183f19c943">

<img width="408" alt="Captura de Tela 2024-05-15 às 23 32 45" src="https://github.com/dantoso/NewsApp/assets/80010223/5f477748-8c8a-412f-8c44-869f6aab52e5">

# How to run it
- In the website [https://newsapi.org/](https://newsapi.org/) generate a free API key.
- In the file _NewsApp/Shared/Info.plist_, under the key **NEWS_API_KEY**, swap the content **YOUR_KEY_HERE** by the key you generated on the website.

  <img width="690" alt="Captura de Tela 2024-05-14 às 18 39 57" src="https://github.com/dantoso/NewsApp/assets/80010223/b3f7fe24-bb56-4ea7-9754-1bc498387424">

- Run the project using a simulator of your choice.

# How I made it

I used the VIPER architecture to structure the project, so the app can be dissected into 5 main layers:
- View: components that render the app's interface
- Interactor: components that implement the system's networking logic
- Presenter: components that manage the communication between interactor and view components
- Entity: components that represent data
- Router: components that implement the app's view cycle and navigation

Besides the layers, VIPER also has another very important feature, which is that all layers (except the Entity layer) must communicate with each other through protocols. In other words: it is a Protocol Oriented architecture. Which is very important for testing


# weather_app

* A simple weather app which uses https://www.metaweather.com/api/

* On startup, the location permission will be prompted to the user, if they give the location permission,
the nearest city's weather details will be shown.

* If the user denied the location access, a default fallback location
is set(Currently it is Berlin) and that city details will be shown

* User can also choose different location clicking the pick location icon on the weather image card.

* User can switch between degree celsius/fahrenheit by clicking on the current temperature on weather detail 

* Clean architecture with bloc state management is used in the app.

* Event though the user cannot change the app theme via UI, this app has light mode and dark mode support.
By default the theme will be in dark mode and we can change that by editing  themeMode: ThemeMode.dark, in main.dart.

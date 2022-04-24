# weather_app

A simple weather app which uses https://www.metaweather.com/api/

On startup, the location permission will be prompted to the user, if they give the location permission,
the nearest city's weather details will be shown.

If the user denied the location access, a default fallback location
is set(Currently it is Berlin) and that city details will be shown

User can also choose different location clicking the pick location icon on the weather image card.

Clean architecture with bloc pattern is used in the app.

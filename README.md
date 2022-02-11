# position_magnitude

First, clone this repo to your local machine. With Docker running in the background, navigate to the repo in a terminal and type the following Docker command:

`docker build -t position_magnitude .`

`docker run --rm -p 8787:8787 -e PASSWORD=password position_magnitude`

Once the container is running, open your browser and point it at: `localhost:8787`. Enter the username `rstudio` and `password` as the password. This will open RStudio running in the container.

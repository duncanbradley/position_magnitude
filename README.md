# position_magnitude

First, clone this repo to your local machine. In a Terminal, navigate to the repo and within it, run the follwing Docker command:

`docker build -t position_magnitude .`

`docker run --rm -p 8787:8787 -e PASSWORD=password position_magnitude`

Once the container is running, open your browser and point it as: `localhost:8787`. Enter the username `RStudio` and `password` as the password. This will open RStudio running in the container.


# example-tech-docs-template-absolute-links

# Background

The [tech-docs-template](https://github.com/alphagov/tech-docs-template) always generates absolute links in certain places, for example the Navbar. This means that a static site generated using this template must be deployed at `/` in order for the links to resolve correctly.

At HMRC we would like to deploy multiple static sites on a single domain, and have each site deployed at a different path e.g:

    docs.tax.service.gov.uk/site1
    docs.tax.service.gov.uk/site2
    etc...

Currently it is not possible to deploy tech-docs-template sites this way.

This issue has already reported as https://github.com/alphagov/tech-docs-gem/issues/271, this repository has been created to provide an easy to reproduce demonstration of the issue, to try and provide a useful contribution to finding a resolution to the issue.

# Steps to reproduce the issue

## Install Docker compose

The example uses Docker Compose to orchestrate the various components in order to demonstrate the issue. Installation instructions can be found [here](https://docs.docker.com/compose/install/)

## Clone this repository

    git clone https://github.com/hmrc/example-tech-docs-template-absolute-links.git

## Open a shell

Open the cloned repository in a shell.

## Build and serve the example site

Open a repository in a shell and run the following command:

    docker compose up

This will:

1. Build the example static site using Middleman
2. Start a web proxy, accessible at http://localhost:8080
3. Configure the web proxy to make the example static site available at http://localhost:8080/. This site will work correctly with absolutely generated links.
4. Configure the web proxy to make the same example static site available at http://localhost:8080/mysite. This site will work not correctly with absolutely generated links.

## Access the static site via the root deployment (/)

Open the root deployed site in a web browser: http://localhost:8080/

You should see 2 links on the homepage, these are relative links and should resolve to a valid path.

Expand the "Home" navbar section.

Look at the links in the navbar section, they are absolute links and (because we've deployed the site at "/") should resolve to a valid location.

## Access the static site via the "mysite" deployment (/mysite)

Open the `/mysite` deployed site in a web browser: http://localhost:8080/mysite

Look at the 2 links on the homepage, because these are relative links they should resolve to a valid location, this time with the `/mysite` prefix e.g. http://localhost:8080/mysite/documentation/section-one

Expand the "Home" navbar section.

Look at the links in the navbar section, because they are absolute links they will still resolve to their original locations e.g. http://localhost:8080/documentation/section-one/ If clicked they will take the user outside the `/mysite` deployment back to the `/` deployment, which of course only exists in this example to demonstrate the issue.

## Stop the Docker containers

To stop the docker containers type `CTRL + C` in the shell in which you executed the `docker compose up` command.

## Delete the Docker containers

To delete the docker containers execute the following command in the same shell:

    docker compose rm -f

# Notes

## Docker volume

If you make any changes to the static site content and want to test them, it is prudent to delete the docker volume to ensure any changes are copied over. To do this ensure the Docker containers are stopped and then do the following:

    docker compose rm -f
    docker volume rm example-tech-docs-template-absolute-links_site
    docker compose up

## Browser port quirk

I have observed that clicking the links in Chrome removes the `8080` port configuration, resulting in the browser being directed to the desired location but on port `80` and the error "localhost refused to connect." being displayed . This isn't an issue with the tech-docs template, it seems to be instead an odd browser quirk. I thought it worth mentioning to avoid any confusion.


### License

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").
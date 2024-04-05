# Sponsor a Pet Theme


## Installation Prerequisites

- [node](https://nodejs.org/en/)
- [shopify-cli](https://shopify.dev/themes/tools/cli/installation)


## Getting Started
1. Clone repository.
```bash
$ git clone git@github.com:Sponsor-a-Pet/shopify-theme.git
```
2. Login and run developement server
```bash
$ shopify theme dev --store=sponsor-a-pet.myshopify.com
```
This will prompt you to open a browser tab where you can login to the Shopify console. Make sure you have admin access after you login.

3. Make sure you are seeing this in the console:
````
➜  theme git:(develop) ✗ shopify theme dev --store=sponsor-a-pet.myshopify.com

╭─ success ─────────────────────────────────────────────────────────────────────────────────╮
│                                                                                           │
│  Preview your theme                                                                       │
│    • http://127.0.0.1:9292                                                                │
│                                                                                           │
│  Next steps                                                                               │
│    • Customize your theme at the theme editor                                             │
│    • Share your theme preview                                                             │
│      (https://sponsor-a-pet.myshopify.com/?preview_theme_id=163721576749)                 │
│                                                                                           │
╰───────────────────────────────────────────────────────────────────────────────────────────╯

* Syncing theme #163721576749 on sponsor-a-pet.myshopify.com
14:20:09 Synced » update assets/CeraPro-Bold.eot
````
4. Grab the `Preview your theme` link from the above console and open this in you browser for navigation.

5. You are good to go! :clap:

## Git Work
1. Switch to `develop` branch.
```
$ git checkout develop
```
2. Pull from origin repository.
```
$ git pull
```
3. Create feature branch for working.
```
$ git checkout -b feature/${FEATURE_NAME}
```
4. Commit changes.
```
$ git add .
$ git commit -m "commit message"
```
5. Push changes.
```
$ git push origin feature/${FEATURE_NAME}
```
6. Create a new pull request.

7. Once merged, it will be automatically synced with shopify online store theme thanks to shopify gitflow.

## Reference
- [Shopify theme documentation](https://shopify.dev/themes)

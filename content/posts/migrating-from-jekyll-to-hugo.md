---
title: "Migrating from Jekyll to Hugo and merging two sites into one"
description: "How I merged alexsalom.es and swifttalking.com into a single Hugo site with a custom theme, Giscus comments and automatic Netlify deploys."
date: 2026-03-25
tags: ["hugo", "web"]
---

For years I ran two separate Jekyll sites: **alexsalom.es** as a personal portfolio and **swifttalking.com** as a blog. Both were hosted on Netlify, both needed their own maintenance, and honestly neither got the attention it deserved. I decided to merge them into one site and migrate to Hugo in the process.

## Why Hugo

Jekyll served me well, but I wanted something faster and simpler to maintain. Hugo ships as a single binary, builds in milliseconds and doesn't need Ruby or Bundler. That alone was enough to convince me.

## What changed

The new **alexsalom.es** combines everything:

- The **homepage** is now a blog index with all the posts that used to live on swifttalking.com
- The **me** page has my bio, skills and social links
- The **projects** page lists everything I've worked on, both professional and personal

I built a custom Hugo theme from scratch inspired by the design of swifttalking.com. No CSS frameworks, no jQuery, just plain HTML, CSS and a few lines of vanilla JavaScript for the mobile menu.

## Preserving URLs

One thing I cared about was not breaking existing links. The old swifttalking.com posts used a `/:title/` URL structure, so I configured Hugo's permalinks to use `:contentbasename` which generates slugs from the filename. Every old URL still works.

## Comments with Giscus

The old blog used [Utterances](https://utteranc.es/) for comments, which stores them as GitHub Issues. I switched to [Giscus](https://giscus.app/) which uses GitHub Discussions instead. Setup was straightforward: enable Discussions on the repo, create a "Comments" category, and drop the script tag into the post template. All the config lives in `hugo.toml` and gets injected via a Hugo partial.

## Automatic deploys

A `netlify.toml` at the root of the repo tells Netlify everything it needs:

```toml
[build]
  publish = "public"
  command = "hugo --minify"

[build.environment]
  HUGO_VERSION = "0.159.0"
```

Every push to `master` triggers a build. The site is live in seconds.

## The result

One repo, one site, zero maintenance overhead. Writing a new post is as simple as creating a Markdown file in `content/posts/` and pushing. Exactly what I wanted.

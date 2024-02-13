---
title: "Human friendly introduction to Bresenham's algorithm"
date: 2024-02-13
description: I present the intuition behind Bresenham's line algorithm.
p5js: true
---

## A few words

In the near future, I'd like to lead a series of creative coding workshops for youth. We'll be drawing various shapes and creating animations in the browser, most likely using [p5.js](https://p5js.org/). However, I need to brush up on my skills a bit.

I've started with a simple problem: drawing a line on a pixel grid, and I've become a bit frustrated. Many resources discussing this topic start with derived math equations, while I need to grasp the intuition first. Here's how I see it.

## The task

Having a computer screen, draw a straight line from pixel A to pixel B. Not with a pen though. Computer screens have milions of pixels nowadays, so let's simplify things a bit. Consider the following conditions:

Grid: ` 6x4`<br />Pixel A: `(1, 1)`<br />Pixel B: `(6, 3)`

Each square represents one pixel on the screen. Let's fill our A and B pixels with color:

<img src="/assets/posts/bresenhams-line/1.jpg" width="400" />

Notice that every integer point lies exactly at the center of a pixel. For instance, the point `(1, 1)` is at the center of pixel A. This is illustrated by the red dot below:

<img src="/assets/posts/bresenhams-line/2.jpg" width="200" />

Alright, so how do we draw the line now? Which pixels on the grid should we color? Remember that we must color entire pixels or none; we can't color half or a third of a pixel.

Let's draw a red helper line that passes through the start and end points, or in other words, through the centers of pixel A and pixel B.

<img src="/assets/posts/bresenhams-line/3.jpg" width="400" />

Now, looking at each column at a time, decide which pixel (relative to its center) is closer to the line.

In the second column (`x = 2`), the pixel below the line is closer.
<br />In the third column (`x = 3`), the pixel above the line is closer.
<br />...and so on.

I've marked the closer distance with a <span style="color: yellow">yellow</span> color, and the longer distance with a gray color:

<img src="/assets/posts/bresenhams-line/4.jpg" width="400" />

Color the pixels that are closer to the helper line:

<img src="/assets/posts/bresenhams-line/5.jpg" width="400" />

That's it. The line can't be any straighter, believe me. You now understand the idea behind [Bresenham's line algorithm](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm).

## Math

I encourage you to derive the equations on a piece of paper. I don't want you to come up with everything on your own, just do it while looking at Ela Claridge's [elegant derivation](/assets/posts/bresenhams-line/bresenhams-derivation.pdf) from the University of Birmingham.

## Play

Feel free to click around. Thank you for reading.

<div id="p5js" style="cursor: pointer"></div>
{{< js "/assets/posts/bresenhams-line/play.js" >}}

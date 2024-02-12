---
title: "Computer graphics: Bresenham's line"
date: 2024-02-12
description: Human friendly introduction to Bresenham's algorithm
draft: true
---

## A few words

In the near future, I'd like to lead a series of creative coding workshops for youth. We'll be drawing various shapes and creating animations in the browser, most likely using [p5.js](https://p5js.org/). However, first things first, I need to brush up on my skills a bit. Starting from scratch, I've decided to draw a straight line on a grid of pixels.

I'm writing this post because many resources discussing this topic just don't quite cut it for me. I also enjoy reminding myself what lies underneath. We build software without fully realizing how much we owe to our predecessors.

## The task

Having a computer screen, draw a straight line from pixel A to pixel B. Not with a pen though. Computer screens have milions of pixels nowadays, so let's simplify things a bit. Consider the following conditions:

Grid: ` 6x4`<br />Pixel A: `(1, 1)`<br />Pixel B: `(6, 3)`

Each square represents one pixel on the screen. Let's fill our A and B pixels with color:

<img src="/images/bresenhams-line/1.jpg" width="400" />

Notice that every integer point lies exactly at the center of a pixel. For instance, the point `(1, 1)` is at the center of pixel A. This is illustrated by the red dot below:

<img src="/images/bresenhams-line/2.jpg" width="200" />

Alright, so how do we draw the line now? Which pixels on the grid should we color? Remember that we must color entire pixels or none; we can't color half or a third of a pixel.

Let's draw a red helper line that passes through the start and end points, or in other words, through the centers of pixel A and pixel B.

<img src="/images/bresenhams-line/3.jpg" width="400" />

Great! Now, looking at each column at a time, decide which pixel (relative to its center) is closer to the line.

In the second column (`x = 2`), the pixel below the line is closer.
<br />In the third column (`x = 3`), the pixel above the line is closer.
<br />...and so on.

I've marked the closer distance with a <span style="color: yellow">yellow</span> color, and the longer distance with a gray color:

<img src="/images/bresenhams-line/4.jpg" width="400" />

Okay. Color the pixels that are closer to the helper line:

<img src="/images/bresenhams-line/5.jpg" width="400" />

That's it. The line can't be any straighter, believe me. You now understand the idea behind [Bresenham's line algorithm](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm).

## Math

let size;
const elements = 20;

let startPixel = null;
let endPixel = null;
let hoverPixel = null;
let filledPixels = [];

const container = document.querySelector("#p5js");

// https://stackoverflow.com/a/4672319
function bresenham(x0, y0, x1, y1) {
  const dx = Math.abs(x1 - x0);
  const dy = Math.abs(y1 - y0);
  const sx = Math.sign(x1 - x0);
  const sy = Math.sign(y1 - y0);
  let err = dx - dy;
  const pixels = [];

  while (true) {
    pixels.push({ x: x0, y: y0 });

    if (x0 === x1 && y0 === y1) break;

    const e2 = 2 * err;
    if (e2 > -dy) {
      err -= dy;
      x0 += sx;
    }
    if (e2 < dx) {
      err += dx;
      y0 += sy;
    }
  }

  return pixels;
}

function handleClick() {
  if (!hoverPixel) return;

  if (endPixel) {
    startPixel = null;
    endPixel = null;
    filledPixels = [];
    return;
  }

  if (startPixel) {
    if (hoverPixel.x == startPixel.x && hoverPixel.y == startPixel.y) {
      return;
    }

    endPixel = hoverPixel;
    filledPixels = bresenham(
      startPixel.x,
      startPixel.y,
      endPixel.x,
      endPixel.y
    );
    return;
  }

  startPixel = hoverPixel;
  filledPixels.push(startPixel);
}

function onMouseMove(event) {
  const rect = event.currentTarget.getBoundingClientRect();
  const relX = event.clientX - rect.left;
  const relY = event.clientY - rect.top;

  const x = Math.floor(relX / size);
  const y = Math.floor(relY / size);

  hoverPixel = { x, y };
}

function onResize() {
  resizeCanvas(container.clientWidth, container.clientWidth * 0.75);
  size = Math.round(container.clientWidth / elements);
}

function setup() {
  size = Math.round(container.clientWidth / elements);

  const canvas = createCanvas(
    container.clientWidth,
    container.clientWidth * 0.75
  );
  canvas.parent("p5js");

  window.addEventListener("resize", onResize);
  container.addEventListener("click", handleClick);
  container.addEventListener("mousemove", onMouseMove);
}

function draw() {
  const rows = Math.ceil(container.clientWidth / size);
  const cols = Math.ceil(container.clientHeight / size);

  // pixels
  fill("#1d1f27");
  stroke("#656565");
  strokeWeight(1);
  for (let i = 0; i < rows; i += 1) {
    for (let j = 0; j < cols; j += 1) {
      rect(i * size, j * size, size);
    }
  }

  // filled pixels
  fill("#007AFF");
  stroke("#007AFF");
  for (const pixel of filledPixels) {
    rect(pixel.x * size, pixel.y * size, size);
  }

  // red helper line
  if (startPixel && hoverPixel) {
    stroke("#F65353");
    strokeWeight(2);

    if (endPixel) {
      // static line
      line(
        startPixel.x * size + size / 2,
        startPixel.y * size + size / 2,
        endPixel.x * size + size / 2,
        endPixel.y * size + size / 2
      );
    } else {
      // following line
      line(
        startPixel.x * size + size / 2,
        startPixel.y * size + size / 2,
        hoverPixel.x * size + size / 2,
        hoverPixel.y * size + size / 2
      );
    }
  }
}

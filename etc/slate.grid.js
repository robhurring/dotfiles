'use strict';
/*jslint todo:true */
/*global slate:true */

/**
 * Flexible CSS-like grid framework for slate window manager
 * Author: rob hurring
 * Source: https://github.com/robhurring/dotfiles/blob/master/etc/slate.grid.js
 *
 * Example Usage:
 *  var grid = new Grid(12);    // create a new 12x12 grid
 *  var grid = new Grid(16);    // create a new 16x16 grid
 *
 * TODO: fix the multi-screen handling stuff, clean it up
 * TODO: offsetting columns on second screen need to be fixed (using the main screen)
 */
var Grid = function(gridSize, opts) {
  this.gridSize = gridSize || 12;
  this.titleBarAdjust = opts.titleBarAdjust || 0;
  this.bottomAdjust = opts.bottomAdjust || 0;
};

Grid.prototype.rectForScreen = function(screenId) {
  return slate.screenForRef(screenId || '0').rect();
};

Grid.prototype.top = function(screenId) {
  return this.rectForScreen(screenId).y;
};

Grid.prototype.left = function(screenId) {
  return this.rectForScreen(screenId).x;
};

// Returns the absolute position to start the column
Grid.prototype.x = function(columns, screenId) {
  return this.left(screenId) + this.columns(columns, screenId);
};

// Returns the absolute position to start the row
Grid.prototype.y = function(rows, screenId) {
  return this.top(screenId) + this.titleBarAdjust + this.rows(rows, screenId);
};

// Returns the pixel size for the amount of columns
Grid.prototype.columns = function(columns, screenId) {
  var rect = this.rectForScreen(screenId);
  return (rect.width / this.gridSize) * Number(columns);
};

// Returns the pixel size for the amount of rows
Grid.prototype.rows = function(rows, screenId) {
  var rect = this.rectForScreen(screenId);
  return ((rect.height - this.bottomAdjust) / this.gridSize) * Number(rows);
};

// Returns the full height of the screen
Grid.prototype.allRows = function(screenId) {
  return this.rows(this.gridSize, screenId);
};

// Returns the full width of the screen
Grid.prototype.allColumns = function(screenId) {
  return this.columns(this.gridSize, screenId);
};

// Convert the column width to a string for use with operations like `nudge`
//
// Examples for colString:
//  '+1'    Add 1 column-width to the current window size
//  '-1'    Remove 1 column width from the current window size
Grid.prototype.normalizeColumns = function(colString, screenId) {
  if(colString === undefined) {
    return '+0';
  }

  var columns = parseInt(colString, 10)
    , operation = (columns > 0 ? '+' : '-');

  return operation + this.columns(Math.abs(columns), screenId);
};

// Convert the row height to a string for use with operations like `nudge`
//
// Examples for rowString:
//  '+1'    Add 1 row-height to the current window size
//  '-1'    Remove 1 row height from the current window size
Grid.prototype.normalizeRows = function(rowString, screenId) {
  if(rowString === undefined) {
    return '+0';
  }

  var rows = parseInt(rowString, 10)
    , operation = (rows > 0 ? '+' : '-');

  return operation + this.rows(Math.abs(rows), screenId);
};

// Return an object with x, y converted to our grid sizes
//
// Examples:
//  slate.operation('nudge', grid.move({x: '+1'}))  // move window 1 col to the right
//  slate.operation('nudge', grid.move({x: '-1'}))  // move window 1 col to the left
//  slate.operation('nudge', grid.move({y: '+1'}))  // move window down 1 row
//  slate.operation('nudge', grid.move({y: '-1'}))  // move window up 1 row
Grid.prototype.move = function(movement) {
  return {
    x: this.normalizeColumns(movement.x, movement.screen),
    y: this.normalizeRows(movement.y, movement.screen)
  };
};

// Return an object with height, width converted to our grid sizes, this is
//  for compatibility with commands like `resize`
//
// Examples:
//  slate.operation('resize', grid.size({width: '+1'}))   // grow window by 1 col
//  slate.operation('resize', grid.size({height: '-1'}))  // shrink window by 1 row
Grid.prototype.size = function(sizing, screenId) {
  return {
    width: this.normalizeColumns(sizing.width, screenId),
    height: this.normalizeRows(sizing.height, screenId)
  };
};

// Return a rect (obj containing x, y, height, width properties) compatible
//  commands such as `layout`. You can pass the following properties:
//
//    column:   The starting column position for the window
//    row:      The starting row position for the window
//    height:   Resize the window the this many rows
//    width:    Resize the window the this many columns
//    size:     (Optional) You can pass in a size with a "HxW", you can use "*" for `gridSize`
//
// Examples:
//   slate.operation('move', grid.rect({column: 3, size: "5x7"}))         // move window into column 3 (row 0) and resize to 5 rows X 7 cols
//   slate.operation('move', grid.rect({column: 5 row: 5, size: "5x6"}))  // move window into column 5 and row 5 and resize to 5 rows X 6 cols
//   slate.operation('move', grid.rect({size: "*"}))                      // move window to col 0, row 0 (top left) and make it 12x12 (full screen)
Grid.prototype.rect = function(rect) {
  var split, newX, newY, newWidth, newHeight;

  if(rect.size !== undefined) {
    split = rect.size.toString().split('x');
    rect.height = split[0];
    // allow for things like {size: '*'} for full screen, so default width if not given
    rect.width = split[1] || '*';
  }

  // turn a '*' into the full width
  if(rect.width === '*') { rect.width = this.gridSize; }
  if(rect.height === '*') { rect.height = this.gridSize; }

  rect.screen = rect.screen || '0';
  newX = rect.column ? this.x(rect.column, rect.screen) : this.left(rect.screen);
  newY = rect.row ? this.y(rect.row, rect.screen) : this.top(rect.screen);
  newWidth = rect.width ? this.columns(rect.width, rect.screen) : 0;
  newHeight = rect.height ? this.rows(rect.height, rect.screen) : 0;

  return {
    x: newX,
    y: newY,
    width: newWidth,
    height: newHeight
  };
};

// alias `fullHeight` -> `allRows`
Grid.prototype.fullHeight = Grid.prototype.allRows;

// alias `fullWidth` -> `allColumns`
Grid.prototype.fullWidth = Grid.prototype.allColumns;

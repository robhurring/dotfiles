'use strict';
/*global slate:true, Grid:true */

slate.configAll({
  defaultToCurrentScreen: true,
  nudgePercentOf: "screenSize",
  resizePercentOf: "screenSize",
  secondsBetweenRepeat: 0.1,
  checkDefaultsOnLoad: true,
  focusCheckWidthMax: 3000,

  windowHintsIgnoreHiddenWindows: false,
  windowHintsShowIcons: true,
  windowHintsSpread: true,
  windowHintsRoundedCornerSize: 10,
  windowHintsSpreadSearchWidth: 200,
  windowHintsSpreadSearchHeight: 200
});

// load our grid
slate.source('~/.slate.grid.js');

var grid = new Grid(12);

slate.bind('esc:cmd', slate.operationFromString('hint'));

// moving around on the grid
slate.bind('right:ctrl;alt', slate.operation('nudge', grid.move({x: '+1'})));
slate.bind('left:ctrl;alt', slate.operation('nudge', grid.move({x: '-1'})));
slate.bind('up:ctrl;alt', slate.operation('nudge', grid.move({y: '-1'})));
slate.bind('down:ctrl;alt', slate.operation('nudge', grid.move({y: '+1'})));

// resizing windows to the grid
slate.bind('right:ctrl;alt;cmd', slate.operation('resize', grid.size({width: '+1'})));
slate.bind('left:ctrl;alt;cmd', slate.operation('resize', grid.size({width: '-1'})));
slate.bind('up:ctrl;alt;cmd', slate.operation('resize', grid.size({height: '-1'})));
slate.bind('down:ctrl;alt;cmd', slate.operation('resize', grid.size({height: '+1'})));

// focusing around
slate.bind('right:alt;cmd', slate.operation('focus', {direction: 'right'}));
slate.bind('left:alt;cmd', slate.operation('focus', {direction: 'left'}));
slate.bind('up:alt;cmd', slate.operation('focus', {direction: 'up'}));
slate.bind('down:alt;cmd', slate.operation('focus', {direction: 'down'}));

// main layout for landscape monitors
slate.layout('DevLandscape', {
  'Flint': {
    'operations': [
      slate.operation('move', grid.rect({size: "5x3"}))
    ]
  },
  'HipChat': {
    'operations': [
      slate.operation('move', grid.rect({size: "5x3"}))
    ]
  },
  'Google Chrome': {
    'operations': [
      slate.operation('move', grid.rect({column: 3, size: "*x5"}))
    ]
  },
  'iTerm': {
    'operations': [
      slate.operation('move', grid.rect({row: 5, size: "7x5"}))
    ]
  },
  'Sublime Text': {
    'operations': [
      slate.operation('move', grid.rect({column: 4, row: 5, size: "*x5"}))
    ]
  },
  'Messages': {
    'operations': [
      slate.operation('move', grid.rect({column: 9, size: "5x3"}))
    ]
  }
});

var layoutName = 'DevLandscape';
slate.bind('1:ctrl;alt;cmd', slate.operation('layout', {
  name: layoutName
}));

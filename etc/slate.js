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

// see which machine we're on
var Machine = {
  mainScreen: null,
  secondaryScreen: null,
  init: function() {
    if(slate.screenCount() > 1) {
      this.mainScreen = slate.screenForRef(0);
      this.secondaryScreen = slate.screenForRef(1);
    } else {
      this.mainScreen = slate.screenForRef(0);
    }
  }
};
Machine.init();

var grid = new Grid(12, {
  bottomAdjust: 22,     // adjust bottom positioning for the title bar
  titleBarAdjust: 22    // when stacking windows drop them so the title bar shows
});
slate.bind('esc:cmd', slate.operationFromString('hint'));

var nudgeWindow = function(opts) {
  return function(window) {
    opts.screen = window.screen().id();
    var op = slate.operation('nudge', grid.move(opts));
    window.doOperation(op);
  };
};

var resizeWindow = function(opts) {
  return function(window) {
    opts.screen = window.screen().id();
    var op = slate.operation('resize', grid.size(opts));
    window.doOperation(op);
  };
};

// opts can be an array, the index will match the screenId
var moveWindow = function(opts) {
  return function(window) {
    var screenId = window.screen().id()
      , moveOp
      , rectOpts;

    if(Array.isArray(opts)) {
      rectOpts = opts[Number(screenId)];
    } else {
      rectOpts = opts;
    }

    rectOpts.screen = screenId;
    moveOp = slate.operation('move', grid.rect(rectOpts));
    window.doOperation(moveOp);
  };
};

// moving around on the grid
slate.bind('right:ctrl;alt', nudgeWindow({x: '+1'}));
slate.bind('left:ctrl;alt', nudgeWindow({x: '-1'}));
slate.bind('up:ctrl;alt', nudgeWindow({y: '-1'}));
slate.bind('down:ctrl;alt', nudgeWindow({y: '+1'}));

// resizing windows to the grid
slate.bind('right:ctrl;alt;cmd', resizeWindow({width: '+1'}));
slate.bind('left:ctrl;alt;cmd', resizeWindow({width: '-1'}));
slate.bind('up:ctrl;alt;cmd', resizeWindow({height: '-1'}));
slate.bind('down:ctrl;alt;cmd', resizeWindow({height: '+1'}));

// focusing around
slate.bind('right:alt;cmd', slate.operation('focus', {direction: 'right'}));
slate.bind('left:alt;cmd', slate.operation('focus', {direction: 'left'}));
slate.bind('up:alt;cmd', slate.operation('focus', {direction: 'up'}));
slate.bind('down:alt;cmd', slate.operation('focus', {direction: 'down'}));

// main layout for landscape monitors
var devLandscape = slate.layout('DevLandscape', {
  'Flint': {
    'operations': [moveWindow([
      {size: '5x3'},
      {row: 4, size: '4x6'}
    ])]
  },
  'HipChat': {
    'operations': [moveWindow([
      {size: '5x3'},
      {size: '4x*'}
    ])]
  },
  'Google Chrome': {
    'operations': [moveWindow({column: 3, size: '*x5'})]
  },
  'iTerm': {
    'operations': [moveWindow([
      {row: 5, size: "7x5"},
      {row: 8, size: "4x*"}
    ])]
  },
  'Sublime Text': {
    'operations': [moveWindow({column: 4, size: "*x5"})]
  },
  'Messages': {
    'operations': [moveWindow([
      {column: 9, size: "5x3"},
      {row: 4, column: 5, size: '4x*'}]
    )]
  }
});

var layoutName = 'DevLandscape';
slate.bind('1:ctrl;alt;cmd', slate.operation('layout', {
  name: layoutName
}));

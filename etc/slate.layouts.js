'use strict';
/*jslint todo:true */
/*global slate:true, Grid:true */

var grid = new Grid(12);

// NOTE: Need to tweak grid - JS not dealing with the dock and multiple monitors aren't
// being besties. snapshots are my solution for right now
//
// opts can be an array, the index will match the screenId
// var moveWindow = function(opts) {
//   return function(window) {
//     var screenId = window.screen().id()
//       , moveOp
//       , rectOpts;

//     if(Array.isArray(opts)) {
//       rectOpts = opts[Number(screenId)];
//     } else {
//       rectOpts = opts;
//     }

//     rectOpts.screen = screenId;
//     moveOp = slate.operation('move', grid.rect(rectOpts));
//     window.doOperation(moveOp);
//   };
// };
// main layout for landscape monitors
// var devLandscape = slate.layout('DevLandscape', {
//   'Flint': {
//     'operations': [moveWindow([
//       {size: '5x3'},
//       {row: 4, size: '4x6'}
//     ])]
//   },
//   'HipChat': {
//     'operations': [moveWindow([
//       {size: '5x3'},
//       {size: '4x*'}
//     ])]
//   },
//   'Google Chrome': {
//     'operations': [moveWindow({column: 3, size: '*x5'})]
//   },
//   'iTerm': {
//     'operations': [moveWindow([
//       {row: 5, size: "7x5"},
//       {row: 8, size: "4x*"}
//     ])]
//   },
//   'Sublime Text': {
//     'operations': [moveWindow({column: 4, size: "*x5"})]
//   },
//   'Messages': {
//     'operations': [moveWindow([
//       {column: 9, size: "5x3"},
//       {row: 4, column: 5, size: '4x*'}]
//     )]
//   }
// });

// var layoutName = 'DevLandscape';
// slate.bind('1:ctrl;alt;cmd', slate.operation('layout', {
//   name: layoutName
// }));
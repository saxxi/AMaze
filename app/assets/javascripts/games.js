var app = angular.module('a-maze', []);

app.directive('aMaze', function() {
  return {
    restrict: 'E',
    scope: {
      grid: '@grid',
    },
    link: function(scope, element, attrs) {
      scope.$watch('grid', function() {
        if (!scope.grid) return;
        var grid = JSON.parse(scope.grid);
        var html = '';
        for (var y = 0; y < grid.length; y++) {
          html += '<div class="cf">';
          for (var x = 0; x < grid[y].length; x++) {
            html += '<div class="cell elem' + grid[y][x] + '"></div>';
          }
          html += '</div>';
        }
        element.html('<div class="cf maze-grid">' + html + '</div>');
      });
    }
  }
});

app.controller('gamesCtrl', function($scope, $http) {
  $scope.maze = {
    width: 40, height: 20
  };

  $scope.game = {
    start_x: 1, start_y: 1,
    end_x: 40, end_y: 20,
  };

  $scope.createGame = function (withDefaults) {
    if (withDefaults) {
      $scope.game = {
        start_x: null, start_y: null,
        end_x: null, end_y: null,
      };
    }
    $scope.error = '';
    $http({
      method: 'POST',
      url: '/games',
      data: { maze: $scope.maze, game: $scope.game }
    }).then(function successCreateGame (response) {
      try {
        $scope.grid = response.data.grid;
      } catch (e) {
        $scope.error = 'There was an error while compiling the game.'
      }
    }, function errorCreateGame (response) {
      $scope.error = 'There was an error on server side, maybe wrong input? You either can compile all positions or none.'
    });
  };

  $scope.createGame();
});

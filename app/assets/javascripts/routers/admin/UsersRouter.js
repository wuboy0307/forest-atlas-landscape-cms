((function (App) {
  'use strict';

    // This collection is used to display the table
  var TableCollection = Backbone.Collection.extend({
    parse: function (data) {
      var keys;
      if (data.length) keys = Object.keys(data[0]);

      return data.map(function (row) {
        var res = {};

        res.row = keys.map(function (key) {
          switch (true) {
            case /enabled/.test(key):
              return {};

            case /(enable|edit|delete)/.test(key):
              // eslint-disable-next-line no-shadow
              var res = {
                name: null,
                searchable: false
              };

              // We need extra attributes when making a put or delete request
              var extraAttributes = '';
              var method = row[key].method;
              if (method === 'delete' || method === 'put') {
                extraAttributes = 'rel="nofollow" data-method="' + method + '"';
                if (method === 'delete') extraAttributes += ' data-confirm="Are you sure?"';
              }

              res.html = '<a href="' + row[key].value + '" class="c-table-action-button -' +
                key + '" title="' + App.Helper.Utils.toTitleCase(key) + '" ' + extraAttributes + '>' +
                App.Helper.Utils.toTitleCase(key) + '</a>';

              return res;

            default:
              return {
                name: key,
                value: row[key].value,
                searchable: row[key].searchable,
                sortable: row[key].sortable
              };
          }
        });

        return res;
      });
    }
  });

  App.Router.AdminUsers = Backbone.Router.extend({

    routes: {
      '(/)': 'index'
    },

    index: function () {
      // We initialize the tabs
      new App.View.TabView({
        el: $('.js-tabs'),
        redirect: true,
        currentTab: 1,
        tabs: [
          { name: 'Sites', url: '/admin/sites/' },
          { name: 'Users', url: '/admin/users/' }
        ]
      });

      var tableCollection = new TableCollection(gon.users, { parse: true });
      var tableContainer = document.querySelector('.js-table');

      if (tableCollection.length === 0) {
        tableContainer.innerHTML = '<p class="no-data">There aren\'t any user to display yet.</p>';
      } else {
        // We initialize the table
        new App.View.TableView({
          el: tableContainer,
          collection: tableCollection,
          tableName: 'List of users',
          searchFieldContainer: $('.js-table-search')[0]
        });
      }
    }
  });
})(this.App));

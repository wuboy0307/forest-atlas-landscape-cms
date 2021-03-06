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
              if (!row[key].value) return '';

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
              }

              var label = key;
              if (key === 'enable' && row.enabled.value) {
                label = 'disable';
              }

              res.html = '<a href="' + row[key].value + '" class="c-table-action-button -' +
                label + ((method === 'delete') ? ' js-confirm' : '') +
                '" title="' + App.Helper.Utils.toTitleCase(label) + '" ' + extraAttributes + '>' +
                App.Helper.Utils.toTitleCase(label) + '</a>';

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

  App.Router.ManagementContexts = Backbone.Router.extend({
    routes: {
      '(/)': 'index'
    },

    index: function () {
      var tableCollection = new TableCollection(gon.contexts, { parse: true });
      var tableContainer = document.querySelector('.js-table');

      if (tableCollection.length === 0) {
        tableContainer.innerHTML = '<p class="no-data">There aren\'t any context to display yet.</p>';
      } else {
        // We initialize the table
        new App.View.TableView({
          el: tableContainer,
          collection: tableCollection,
          tableName: 'List of contexts',
          searchFieldContainer: $('.js-table-search')[0],
          sortColumnIndex: 0
        });
      }
    }
  });
})(this.App));

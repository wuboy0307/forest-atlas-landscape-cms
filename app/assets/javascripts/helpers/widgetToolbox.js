((function (App) {
  'use strict';

  // This helper is key to help identify which widgets can be rendered
  // depending on the data we have
  // It's also used to validate states

  /**
   * Constructor of the WidgetToolbox helper
   * @param {object[]} dataset
   */
  App.Helper.WidgetToolbox = function (dataset) {
    if (!dataset) {
      throw new Error('The widget toolbox needs to be constructed with a dataset');
    }
    this.dataset = dataset;
    this.jiminy = this._getJiminyInstance();
  };

  /* eslint-disable no-underscore-dangle */

  /**
   * Return an instance of Jiminy
   * @returns {object} instance
   */
  App.Helper.WidgetToolbox.prototype._getJiminyInstance = function () {
    return new Jiminy(this.dataset, App.Helper.ChartConfig);
  };

  /**
   * Return the list of charts that can be generated with the dataset
   * @returns {string[]}
   */
  App.Helper.WidgetToolbox.prototype.getAvailableCharts = function () {
    return this.jiminy.recommendation();
  };

  /**
   * Return the available x columns for the selected chart
   * @param {string} chart - check the available columns for this specific chart
   * @returns {string[]}
   */
  App.Helper.WidgetToolbox.prototype.getAvailableXColumns = function (chart) {
    return this.jiminy.columns(chart);
  };

  /**
   * Return the available y columns for the selected chart
   * @param {string} chart - check the available columns for this specific chart
   * @param {string} xColumn - x column name
   * @returns {string[]}
   */
  App.Helper.WidgetToolbox.prototype.getAvailableYColumns = function (chart, xColumn) {
    return this.jiminy.columns(chart, xColumn);
  };

  /**
   * Return two random columns that can be used to generate the chart (x and y)
   * The y column can be null depending on the chart
   * @param {string} chart
   * @return {{ x: string, y: string }}
   */
  App.Helper.WidgetToolbox.prototype.getChartRandomColumns = function (chart) {
    var xColumns = this.getAvailableXColumns(chart);
    var xColumn;
    if (!xColumns.length) {
      // eslint-disable-next-line no-console
      console.warn('Unable to generate a ' + chart + ' chart out of the current dataset');
      return { x: null, y: null };
    }

    xColumn = xColumns[0];

    var yColumns = this.getAvailableYColumns(chart, xColumn);
    var yColumn = yColumns.length ? yColumns[0] : null;

    return {
      x: xColumn,
      y: yColumn
    };
  };

  /**
   * Return the charts configuration object
   * @return {object} chart config
   */
  App.Helper.WidgetToolbox.prototype.getChartConfig = function () {
    return App.Helper.ChartConfig;
  };

  /**
   * Check the validity of a chart regarding the data provided to the constructor
   * @param {{ type: string, x: string, y: string | null}} chart
   * @returns {boolean} validity - true if valid
   */
  App.Helper.WidgetToolbox.prototype.checkChartValidity = function (chart) {
    // If the chart hasn't a type, we consider it as valid
    if (!chart.type) return true;
    // If the chart can't be rendered with the current dataset
    if (this.getAvailableCharts().indexOf(chart.type) === -1) return false;
    // If the x column can be chosen to render the chart
    if (this.getAvailableXColumns(chart.type).indexOf(chart.x) === -1) return false;
    // If the y column can be chosen to render the chart with the x column
    // NOTE: not all the charts have two columns
    if (this.getAvailableYColumns(chart.type, chart.x).length && (!chart.y || this.getAvailableYColumns(chart.type, chart.x).indexOf(chart.y) === -1)) return false;
    // If we reach this point, this particular chart is valid
    return true;
  };

  /**
   * Check the validity of a state regarding the data provided to the constructor
   * For now, only the charts are checked
   * @param {object} state
   * @returns {boolean} validity - true if valid
   */
  App.Helper.WidgetToolbox.prototype.checkStateValidity = function (state) {
    return state.config.charts.reduce(function (isValid, chart) {
      return isValid && this.checkChartValidity(chart);
    }.bind(this), true);
  };

  /* eslint-enable no-underscore-dangle */
})(this.App));

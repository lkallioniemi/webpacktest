const path = require('path');
const { argv } = require('yargs');
const merge = require('webpack-merge');

const userConfig = require('../config');

const isProduction = !!((argv.env && argv.env.production) || argv.p);
const rootPath = (userConfig.paths && userConfig.paths.root)
    ? userConfig.paths.root
    : process.cwd();

const config = merge({
	copy: 'images/**/*',
	proxyUrl: 'http://localhost:3000',
	cacheBusting: '[name]_[hash]',
	paths: {
	    root: rootPath,
	    assets: path.join(rootPath, 'source'),
	    dist: path.join(rootPath, 'themes/mll/assets'),
	},
	enabled: {
	    sourceMaps: !isProduction,
	    optimize: isProduction,
	    cacheBusting: isProduction,
	    watcher: true,
	},
	watch: userConfig.watch,
	browsers: [],
    }, userConfig);

module.exports = merge(config, {
	env: Object.assign({ production: isProduction, development: !isProduction }, argv.env),
	publicPath: `${config.publicPath}/${path.basename(config.paths.dist)}/`,
	manifest: {},
    });

/**
 * If your publicPath differs between environments, but you know it at compile time,
 * then set SAGE_DIST_PATH as an environment variable before compiling.
 * Example:
 *   SAGE_DIST_PATH=/wp-content/themes/sage/dist yarn build:production
 */
if (process.env.SAGE_DIST_PATH) {
    module.exports.publicPath = process.env.SAGE_DIST_PATH;
}

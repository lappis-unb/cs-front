var path = require("path");
var UglifyJSPlugin = require('uglifyjs-webpack-plugin');
var ELM_PROD_ENV = JSON.parse(process.env.ELM_PROD_ENV || false);

module.exports = {
    entry: {
        app: [
            './public/index.js'
        ]
    },

    output: {
        path: path.resolve(__dirname + '/dist'),
        filename: '[name].bundle.js',
    },

    module: {
        rules: [
            {
                test: /\.scss$/,
                use: [{
                    loader: "style-loader" // creates style nodes from JS strings
                }, {
                    loader: "css-loader" // translates CSS into CommonJS
                }, {
                    loader: "sass-loader" // compiles Sass to CSS
                }]
            },
            /*
            {
                test: /\.(css)$/,
                use: [
                    'style-loader',
                    'css-loader',
                ]
            },
            */

            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]',
            },

            /*
            {
                test: /\.html$/,
                use: {
                    loader: 'polymer-webpack-loader',
                }
            },
            */
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: {
                    loader: 'elm-webpack-loader',
                    options: {
                        verbose: true,
                        warn: true,
                        debug: !ELM_PROD_ENV
                    }
                }
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'url-loader?limit=10000&mimetype=application/font-woff',
            },
            {
                test: /\.(ttf|eot|svg|png|jpg|gif)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader',
            },
        ],

        noParse: /\.elm$/,
    },

    devServer: {
        inline: true,
        stats: { colors: true },
    },

    plugins: ELM_PROD_ENV ? [
        new UglifyJSPlugin()
    ] : []
};
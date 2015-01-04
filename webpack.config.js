module.exports = {
    devtool: "source-map",
    entry: {
        app: ['webpack/hot/dev-server', './app/index.js']
    },
    output: {
        path: './build',
        filename: 'bundle.js'
    },
    devServer: {
        contentBase: "./build"
    },
    module: {
        loaders: [
            { test: /\.coffee$/, loader: "coffee-loader" }
        ]
    },
    resolve: {
        extensions: ["", ".web.coffee", ".web.js", ".coffee", ".js"]
    }
};
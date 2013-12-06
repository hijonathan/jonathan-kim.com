humanize = require('humanize-plus');


function slugify(value) {
    return value.replace(/_/g, '-');
}

function dateSlug() {
    var date = new Date(),
        iso = date.toISOString();
    return iso.substr(0, iso.indexOf('T'));
}


module.exports = function(Handlebars) {

    Handlebars.registerHelper('slug', function(str) {
        return dateSlug() + '-' + slugify(str);
    });

    Handlebars.registerHelper('slugify', slugify);

    Handlebars.registerHelper('titleCase', function(str) {
        return humanize.titleCase(str.replace(/-/g, ' '));
    });

};

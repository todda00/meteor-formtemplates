Package.describe({
  name: 'todda00:formtemplates',
  version: '0.0.2',
  // Brief, one-line summary of the package.
  summary: 'Provides form templates for a variety of bootstrap form elements',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/todda00/meteor-formtemplates.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use(['coffeescript','jquery','templating']);

  api.versionsFrom('1.0.3.1');
  api.addFiles('todda00:formtemplates.js');
  api.addFiles([
    'formTemplates.html',
    'formTemplates.coffee'
  ],'client');
});
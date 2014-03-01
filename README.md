# Pandoc Preview

Run your current file through Pandoc and preview the output within Atom.

Commands:

  * `Pandoc Preview: Show` will run the current buffer through Pandoc and show it in a new pane.

There are two config settings:

  * `pandoc.cmd` which is the pandoc executable. This needs to be on your `PATH`.
  * `pandoc.args` which are the command-line arguments to pandoc, defaults to `-f markdown -t html5 -s -S --self-contained`.

## Limitations

  * It's dumb at the moment. Very dumb. By default, it assumes your file is Markdown and outputs HTML5. That's it.
  * The styles are quite ugly.
  * Full page output, including custom stylesheets, will screw with Atom quite significantly.

## Problems with PATH

To find the `pandoc` executable, ideally Atom should be able to find it on your `PATH`. Unfortunately, environment variables are a bit of an issue with GUI applications on OS X. Google it or see [Setting Environment Variables in OS X?](http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x).

For the `atom` command, you need to make sure Atom is loaded via env (which it isn't currently).

    vim `which atom`

Change:

    open -a $ATOM_PATH -n --args --executed-from="$(pwd)" --pid=$$ $@

to:

    env open -a $ATOM_PATH -n --args --executed-from="$(pwd)" --pid=$$ $@

Now Atom will have access to `PATH`, and can find your `pandoc` command.

# timewalk

An automated date parser for ArchivesSpace.

timewalk will automatically parse any values in ArchivesSpace's Date Expresssion field into ISO8601-compliant `Begin` and `End` values.  In addition, it will parse out date certainties and set the calendar/era values automatically.

## Expectations on Data Entry

timewalk will parse any single date, or date span, properly.  The following dates will parse correctly:

```
January 1900
[February 1860 - March 20, 1990]
ca. 1950 to 1960
```

Date lists will _not_ parse as expected, as the parser will break them into discrete dates.  The following examples will not parse:

```
1999, 2000
January 1900; December 2000
February 20 and April 19, 1950
```

These dates should be broken into distinct Date entries in ArchivesSpace regardless; in other words, timewalk behaves as expected, assuming good data practice.

## Installation

Create a `plugins/timewalk` directory in your ArchivesSpace directory, copy the repository into that directory, and add `timewalk` to your `AppConfig[:plugins]` list.

## Credits

Created by Alexander Duryee at The New York Public Library.

timewalk is built on [timetwister](https://github.com/alexduryee/timetwister), created by a cast of characters at the New York Public Library.
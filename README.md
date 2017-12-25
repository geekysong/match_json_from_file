# MatchJsonFromFile

For a given file containing an json array, match the object based on the search
query

## Installation

In the folder, do:

```bash
gem build match_json_from_file
gem install match_json_from_file-*.gem
```

## Usage

```bash
match_json_from_file /path/to/file.json "key1:value1;key2:value2"
```

Note that key supports nested syntax. Therefore, syntax like "parent.child:v" is
supported. The value can also be an integer or float.

## TODOs

- [ ] input arguments
  - supports (therefore, needs to define) the query types
  - display help message on default
  - supports array query
- [ ] error handling
  - make sure to display meaningful error message on error
- [ ] program effiency
  - test with large file
  - make sure it doesn't provide too much garbage

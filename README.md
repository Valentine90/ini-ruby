## About
![lANG](https://img.shields.io/badge/LANG-RUBY(%20RGSS%20)-red?style=for-the-badge&logo=appveyo)
<p>Reads data from INI files simply and quickly. This script reads integers, UTF-8 encoded strings, booleans and floats.</p>

## Example
```Ruby
filename = 'Settings.ini'
ini = INI.load_file(filename)
ini[:user][:name] #=> 'Jonny'
ini[:user][:age] #=> 15
ini[:user][:registered] #=> true
```

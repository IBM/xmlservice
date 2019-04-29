# XMLSERVICE

XMLSERVICE is a set of procedures written in ILE RPG that allow you to interact with IBM i resources such as programs and commands using a plain XML protocol. XMLSERVICE can be called directly or via high-level language toolkit.

![XMLSERVICE visualization](https://raw.githubusercontent.com/IBM/xmlservice/master/xmlservice.png)

## Example

TODO ...

## Documentation

Documentation is at https://xmlservice.readthedocs.io/

## Building from Source

### Build requirements

Building requires Python 3 and GNU make. These can be installed with `yum`: `yum install python3 make-gnu`

You will also need the ILE RPG compiler installed (5770-WDS option 31) along with the following PTFs:

- 7.3: SI62605
- 7.2: SI62604
- 7.1: SI62580

### Building

```sh
PATH=/QOpenSys/pkgs/bin:$PATH

git clone https://github.com/IBM/xmlservice.git

cd xmlservice

python3 ./configure

make
```

### Customizing the Build

You can customize the build by passing options to `configure`:

- `--library`: set the build library
- `--debug`: set the debug level (DBGVIEW CL parameter)

## Running the Tests

TODO ...

## Language Toolkits

- [.NET](https://github.com/richardschoen/IbmiXmlserviceStd)
- [Node.js](https://github.com/IBM/nodejs-itoolkit)
- [PHP](https://github.com/zendtech/IbmiToolkit)
- [Python](https://github.com/IBM/python-itoolkit)
- [Ruby](https://bitbucket.org/litmis/ruby-itoolkit)
- [Swift](https://bitbucket.org/litmis/swift-itoolkit)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Releasing a New Version

This project uses [bumpversion](https://github.com/peritus/bumpversion) to manage its version numbers. To update official releases, run the following commands:

```
# checkout and pull the latest code from master
git checkout master
git pull

# bump to a release version (a tag and commit are made)
bumpversion release

# bump to the new dev version (a commit is made)
bumpversion --no-tag patch

# push the new tag and commits
git push origin master --tags
```

## License

[BSD](LICENSE)

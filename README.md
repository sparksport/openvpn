# CircleCI OpenVPN 2 Orb


[![CircleCI Build Status](https://circleci.com/gh/sparksport/openvpn.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/sparksport/openvpn) [![CircleCI Orb Version](https://badges.circleci.com/orbs/sparksport/openvpn.svg)](https://circleci.com/orbs/registry/orb/sparksport/openvpn) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/sparksport/openvpn/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

Set of commands which allow you to establish a OpenVPN connection within a CircleCI build job.

### Recommended executor
```
executors:
    machine:
      image: ubuntu-2004:202201-02
```
See ubuntu-2004:202201-02 notes [here](https://discuss.circleci.com/t/linux-machine-executor-images-2022-january-q1-update/42831) 


### Required environment variables 
- `VPN_USERNAME`
- `VPN_PASSWORD`
- `VPN_CONFIG`

`VPN_CONFIG` has to contain a Base64 encoded OpenVPN config file eg. `.ovpn` format.

See [CircleCI Documentation](https://circleci.com/docs/2.0/env-vars) for instructions on how you would set this up.

### Usage

Example use as well as a list of available executors, commands, and jobs are available on this orb's [registry page][reg-page].
```
jobs:
    - openvpn/install
    - openvpn/connect
    - run:
        name: your command here
        command: curl -s http://checkip.amazonaws.com
    - openvpn/disconnect
```
---

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/sparksport/openvpn) - The official registry page of this orb for all versions, executors, commands, and jobs described.

[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using, creating, and publishing CircleCI Orbs.

[OpenVPN (2.x)](https://support.circleci.com/hc/en-us/articles/360049397051-How-to-set-up-a-VPN-connection-during-builds#machine)

### How to Contribute

We welcome [issues](https://github.com/sparksport/openvpn/issues) to and [pull requests](https://github.com/sparksport/openvpn/pulls) against this repository!

### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info sparksport/openvpn | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/sparksport/openvpn/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.

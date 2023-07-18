<p align="center">
    <img width="450" src="/media/logo.png">
</p>

Frigg SubFinder is a subdomain enumeration tool designed to discover hidden and unauthorized subdomains within a parent domain. With this tool, you can carry out a comprehensive and automated subdomain search process, allowing you to get a complete picture of a domain's infrastructure and improve the security of your network.

## Install

```bash
git clone https://github.com/grepmam/frigg-subfinder.git
cd frigg-subfinder
cpan Getopt::Long HTTP::Tiny JSON HTML::TreeBuilder
```

## Module list

**Frigg** has five easy-to-use modules. These are divided according to the enumeration technique, passive and active (for now one).

#### Passive

* CertificateTransparency
* GoogleDorking (Requires API Key and a Searcher ID)
* DNSAggregators
* OSINT

*Note: some modules such as DNSAggregators may not work correctly due to the number of requests made.*

#### Active

* BruteForce

*Note: for now the Brute Force module enumeration is sequential (slow) and not done by threads.*

## Usage Examples

Launch enumeration by Brute Force: 

```bash
./frigg active module BruteForce -d <domain>
```

Launch enumeration by Google Dorking (limited):

```bash
./frigg.pl passive module GoogleDorking -d <domain> -a <api_key> -s <sengid>
```

## Final notes

As mentioned in some notes, some modules can crash, they have their limitations. There are still more engines to add to some modules. Over time, efforts will be made to improve this program.

#!/bin/bash
# a scrpit to filter out very common websites from a stream of URLs

grep -v "^\(https\?://academic.microsoft.com/\|https\?://www.scopus.com/\|https\?://gateway.webofknowledge.com/\|https\?://europepmc.org/\|https\?://publons.com/\|https\?://www.researcherid.com/\|https\?://portal.issn.org/\|https\?://inspirehep.net/\|https\?://arxiv.org/\|https\?://www.mendeley.com/\|https\?://www.worldcat.org/\|https\?://www.mdpi.com/\|https\?://www.base-search.net/\|https\?://ui.adsabs.harvard.edu/\|https\?://loop.frontiersin.org/\|https\?://www.researchgate.net/\)"




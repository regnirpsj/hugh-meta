======================================
Hull University Graphics Helper (HUGH)
======================================

.. image:: https://travis-ci.org/regnirpsj/hugh-meta.svg?branch=master
   :target: https://travis-ci.org/regnirpsj/hugh-meta

:Author: Jan P Springer <regnirpsj@gmail.com>

.. contents::

.. _CMake:                          http://www.cmake.org/
.. _Department of Computer Science: http://www2.hull.ac.uk/science/computer_science.aspx
.. _The University of Hull:         http://www.hull.ac.uk/
.. _hugh-fields:                    http://github.com/regnirpsj/hugh-fields
.. _hugh-scene:                     http://github.com/regnirpsj/hugh-scene
.. _hugh-support:                   http://github.com/regnirpsj/hugh-support

Introduction
============

``hugh-meta`` is the meta project for building all sub-projects for HUGH an (experimental) infrastructure project to support the various graphics modules at the `Department of Computer Science`_, `The University of Hull`_.

Building and Installation
=========================

Quick Setup
-----------

Linux::

 $> cd <src-dir-created-by-git-clone>
 $> mkdir build && cd build
 $> cmake -DCMAKE_INSTALL_PREFIX=../install ..
 $> cmake --build .

Windows x86::

 $> cd <src-dir-created-by-git-clone>
 $> mkdir build.x86 && cd build.x86
 $> cmake -DCMAKE_INSTALL_PREFIX=../install.x86 ..
 $> cmake --build . -- /nologo /v:q

 Options after `--` apply to `MSBuild.exe`.
 
Windows x64::

 $> cd <src-dir-created-by-git-clone>
 $> mkdir build.x64 && cd build.x64
 $> cmake -G "Visual Studio 12 2013 Win64" -DCMAKE_INSTALL_PREFIX=../install.x64 ..
 $> cmake --build . -- /nologo /v:q

 Replace the `Visual Studio 12 2013 Win64` generator version as needed.
 
Overview
--------

[to be written]

Requirements
------------

Mandatory:

* `CMake`_
* `hugh-fields`_
* `hugh-scene`_
* `hugh-support`_

Acknowledgements
================

[to be written]

License
=======

Copyright 2016 `The University of Hull`_. Distributed under the LGPLv2.1 (see the accompanying file LICENSE).

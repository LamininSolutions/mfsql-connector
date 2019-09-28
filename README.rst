SQL rST Documentation Guide
===========================

Documenting MFSQL Connector has moved from Jira Wiki to using Sphinx document generator. It applies StructuredText as markup language and publish the site to github.

http://www.sphinx-doc.org/en/master/

The core structure of the documentation are

Structure
---------

1. Sections about MFSQL Connector
2. Blogs
3. Extract from inline documentation in the SQL Scripts

A python procedure strips out the rst section of each SQL script in the Connector repository.  This is combined with the other rst based files and folders in the mfsql-connector repository. The mfsql-connector repository is monitored by Sphinx to convert the rst into html to produce the website.

Videos
------

.. code:: rst

    .. raw:: html

        <iframe width="560" height="315" src="https://www.youtube.com/embed/yU1EAeKkTso" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Referencing components
----------------------

.. code:: rst

    :ref:`/procedures/spMFUpdateTable`

Web-site error check
--------------------
https://travis-ci.org/lamininsolutions

rST cheatsheet
--------------

http://docutils.sourceforge.net/docs/user/rst/quickref.html

Order of title underlines is ``=`` -> ``-`` -> ``~``

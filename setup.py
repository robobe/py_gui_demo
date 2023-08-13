from setuptools import find_packages, setup
from py_gui_demo import __version__

setup(
    name="py_gui_demo",
    version=__version__,
    description="description",
    author="",
    author_email="",
    platforms=["any"],
    license="BSD",
    packages=find_packages(),
    entry_points={
        "console_scripts": [
            "my_app = py_gui_demo.main:main",
        ],
    },
    install_requires=[
        "pysimplegui"
    ]
)

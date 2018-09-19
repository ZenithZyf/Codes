README
======

The wavelet denoise plugin for The GIMP is an algorithm copied and slightly
altered from the UFRaw program (which inherited the algorithm from dcraw).
Instead of denoising all RGB channels at once the plugin implementation allows
to denoise the RGB channels individually and - even more useful - to denoise
the YCbCr channels individually. The YCbCr conversion is nearly lossless as
the internal calculations are done in floating point numbers and
rounding errors are avoided.

LICENCE
-------

Copyright (C) 2008 by Marco Rossini. Distributed under the General Public
License. See the file COPYING which contains the license.

INSTALLATION
------------

See the file INSTALL for instructions how to install the plugin.

USAGE
-----

Once the plugin is installed successfully, the plugin can be found in The GIMP
using the menu "Filters->Enhance->Wavelet denoise". It works for both Grayscale
and RGB (full colour) images, including alpha channels. The plugin dialog
allows to adjust several parameters.

1. First, the choice has to be made over what colour model is to be used. There
   are two possibilities (maybe there will be more in the future):

     a) RGB     (red-green-blue)
     b) YCbCr   (luminance-blueness-redness)

   The YCbCr allows separate reduction of luminance and chroma (colour) noise.

2. The preview mode can be selected. Either all channels can be selected or
   the current active channel which is then displayed in grayscale or colour.

3. Select the channel you want to denoise.

4. The sliders adjust the amount of denoising and the 'detail' for the selected
   channel. 'Detail' means the amount of low frequency noise that is removed
   along with the image details. A high amount of 'detail' increases image
   details and sharpness.

For camera pictures I advise to use YCbCr mode (which is nearly lossless) and
to at least denoise the Cb and Cr channels to reduce the chroma (colour) noise.
Cameras shooting in JPEG mode normally have chroma noise already reduced. If
desired, the luminance noise can be reduced. This channel usually contains
most of the fine structures in the image and should mostly be left alone.

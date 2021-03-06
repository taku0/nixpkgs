{ lib, fetchPypi, buildPythonPackage, isPy3k, setuptools-scm, pygccxml }:
buildPythonPackage rec {
  pname = "PyBindGen";
  version = "0.21.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "4501aa3954fdac7bb4c049894f8aa1f0f4e1c1f50cc2303feef9bbe3aecfe364";
  };

  buildInputs = [ setuptools-scm ];

  checkInputs = [ pygccxml ];
  doCheck = (!isPy3k); # Fails to import module 'cxxfilt' from pygccxml on Py3k

  meta = with lib; {
    homepage = "https://github.com/gjcarneiro/pybindgen";
    description = "Python Bindings Generator";
    license = licenses.lgpl2;
    maintainers = with maintainers; [ teto ];
  };
}

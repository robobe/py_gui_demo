from py_gui_demo.main import calc

def test_add():
    result = calc()
    assert result == 20
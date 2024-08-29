import QtQuick 2.15
import QtTest 1.2

TestCase {
    name: "ExampleTest"

    function initTestCase() {
        // Configuration initiale du test
        console.log("Initialisation du test")
    }

    function test_example() {
        // Exemple de test simple
        var x = 5
        var y = 10
        compare(x + y, 15, "Addition simple échouée")
    }

    function cleanupTestCase() {
        // Nettoyage après les tests
        console.log("Nettoyage après les tests")
    }
}

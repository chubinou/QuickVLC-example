#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>

int main(int argc, char *argv[])
{
    // this important so we can call makeCurrent from our rendering thread
    QCoreApplication::setAttribute(Qt::AA_DontCheckOpenGLContextThreadAffinity);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("./qml");

    const QUrl url(u"qrc:/example/main.qml"_qs);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    qDebug() << engine.pluginPathList();

    return app.exec();
}

/*
* Copyright (C) 2020 ~ 2021 Uniontech Software Technology Co.,Ltd.
*
* Author:     tangpeng <tangpeng@uniontech.com>
*
* Maintainer: tangpeng <tangpeng@uniontech.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef DUE_CAMERA_PRO
#include "config.h"
#else
#define VERSION "1.0.0.1"
#endif


#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>
#include <QDebug>
#include <QScreen>
#include <QQuickView>
#include <QVariant>

#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusPendingCall>

#include <QVariant>
#include <QDBusVariant>

#include "filecontrol.h"

int main(int argc, char *argv[])
{
    qInfo() << "start dte album : " << VERSION;
    QSurfaceFormat format = QSurfaceFormat::defaultFormat();
    QSurfaceFormat::RenderableType module =  QSurfaceFormat::OpenGLES;
    format.setRenderableType(module);
    QSurfaceFormat::setDefaultFormat(format);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("something");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("fileControl", new FileControl());

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
    &app, [url](QObject * obj, const QUrl & objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFile>
#include <QDir>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>

#include <cstdio>
#include <time.h>

const QString database_file_name = "db.sqlite";

#define CREATE_TABLE_STRING \
    "CREATE TABLE IF NOT EXISTS RATINGS (" \
        "RATING INT NOT NULL, " \
        "DATE CHAR(10) NOT NULL UNIQUE," \
        "WAKEUP CHAR(5) NOT NULL," \
        "SLEEP CHAR(5)," \
        "EXERCISE BOOL" \
        "BREAKFAST BOOL" \
        "DINNER BOOL" \
        "MENU BOOL" \
        "CLEANING BOOL" \
        "HAIRCUT BOOL" \
        "SHOWER BOOL" \
        "DISHES BOOL" \
        "YOUTUBE BOOL" \
        "GAMING BOOL" \
    ");"

class RatingManager : public QObject
{
    Q_OBJECT

    QSqlDatabase database;

public:
    RatingManager()
    {
        const QString database_path = QDir::currentPath() + "/" + database_file_name;

        qDebug() << "Opening database file: " << database_path;

        this->database = QSqlDatabase::addDatabase("QSQLITE");
        this->database.setDatabaseName(database_path);
        if(!this->database.open())
        {
            qCritical() << "Failed to open database";
            return;
        }

        QSqlQuery query;

        if(!query.exec(CREATE_TABLE_STRING))
        {
            qCritical() << "Failed to create RATINGS table";
            return;
        }
    }

    ~RatingManager()
    {
        this->database.close();
    }

public slots:
    Q_INVOKABLE void addRating(const QString &msg) {
        qDebug() << "Called the C++ slot with message:" << msg;

        char current_date_buffer[200];
        time_t t;
        struct tm *tmp;

        t = time(NULL);
        tmp = localtime(&t);
        if (tmp == NULL) {
            qDebug() << "Failed to get time";
        }

        if (strftime(current_date_buffer, sizeof(current_date_buffer), "%d/%m/%Y", tmp) == 0) {
            qDebug() << "Failed to format time";
        }

        char query_string_buffer[512];
        snprintf(query_string_buffer, sizeof(query_string_buffer), "INSERT INTO RATINGS (RATING, DATE) VALUES (5, '%s')", current_date_buffer);

        qDebug() << "Executing SQL Statement: ";
        qDebug() << query_string_buffer;

        QSqlQuery query;
        if(!query.exec(query_string_buffer))
        {
            qWarning() << "Failed to executate INSERT statement";
        }
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("DayRater", "Main");

    QQmlContext *context = engine.rootContext();

    RatingManager rating_manager;
    context->setContextProperty("rating_manager", &rating_manager);

    return app.exec();
}

#include "main.moc"

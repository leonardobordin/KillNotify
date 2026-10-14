package dev.killnotify.probe;

import android.Manifest;
import android.app.Activity;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

public final class ProbeActivity extends Activity {
    private static final String CHANNEL_ID = "synthetic_notifications";
    private static final String GROUP_KEY = "synthetic_group";
    private static final int SINGLE_ID = 100;
    private int updateVersion = 1;
    private NotificationManager notifications;
    private TextView actionCount;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        notifications = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notifications.createNotificationChannel(new NotificationChannel(
                CHANNEL_ID, "Notificações sintéticas", NotificationManager.IMPORTANCE_DEFAULT));

        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setGravity(Gravity.CENTER_HORIZONTAL);
        layout.setPadding(32, 48, 32, 32);

        TextView heading = new TextView(this);
        heading.setText("Produtor de notificações sintéticas\n\nUse somente para validar o protótipo do KillNotify.");
        heading.setTextSize(19);
        layout.addView(heading, matchWrap());
        actionCount = new TextView(this);
        actionCount.setTextSize(16);
        layout.addView(actionCount, matchWrap());
        addButton(layout, "Publicar original com ação", this::postSingle);
        addButton(layout, "Atualizar o mesmo ID", this::updateSingle);
        addButton(layout, "Publicar notificação com ID novo", this::postFreshNotification);
        addButton(layout, "Publicar grupo com duas originais", this::postGroup);
        addButton(layout, "Cancelar notificações do teste", this::cancelAll);
        setContentView(layout);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (actionCount != null) {
            int count = getSharedPreferences("probe_state", MODE_PRIVATE).getInt("action_count", 0);
            actionCount.setText("Ações originais executadas: " + count);
        }
    }

    private void addButton(LinearLayout layout, String label, Runnable action) {
        Button button = new Button(this);
        button.setText(label);
        button.setOnClickListener(view -> {
            if (!canPost()) return;
            action.run();
        });
        layout.addView(button, matchWrap());
    }

    private boolean canPost() {
        if (Build.VERSION.SDK_INT < 33 || checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS)
                == PackageManager.PERMISSION_GRANTED) return true;
        requestPermissions(new String[]{Manifest.permission.POST_NOTIFICATIONS}, 33);
        return false;
    }

    private void postSingle() {
        updateVersion = 1;
        notifications.notify(SINGLE_ID, singleNotification(SINGLE_ID, updateVersion));
    }

    private void updateSingle() {
        updateVersion++;
        notifications.notify(SINGLE_ID, singleNotification(SINGLE_ID, updateVersion));
    }

    private void postFreshNotification() {
        int id = getSharedPreferences("probe_state", MODE_PRIVATE).getInt("fresh_id", 299) + 1;
        getSharedPreferences("probe_state", MODE_PRIVATE).edit().putInt("fresh_id", id).apply();
        notifications.notify(id, singleNotification(id, 1));
    }

    private Notification singleNotification(int id, int version) {
        Notification.Builder builder = base(id, "Teste sintético v" + version,
                "Texto fixo de teste; sem dados pessoais.");
        Intent actionIntent = new Intent(this, ProbeActionReceiver.class)
                .setAction("dev.killnotify.probe.SYNTHETIC_ACTION")
                .putExtra("probe_version", version);
        PendingIntent action = PendingIntent.getBroadcast(this, 500 + id + version, actionIntent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        builder.addAction(android.R.drawable.ic_menu_view, "Ação de teste", action);
        return builder.build();
    }

    private void postGroup() {
        notifications.notify(201, grouped(201, "Item sintético A"));
        notifications.notify(202, grouped(202, "Item sintético B"));
        Notification summary = base(203, "Grupo sintético", "Resumo do produtor de teste")
                .setGroup(GROUP_KEY)
                .setGroupSummary(true)
                .setGroupAlertBehavior(Notification.GROUP_ALERT_SUMMARY)
                .build();
        notifications.notify(203, summary);
    }

    private Notification grouped(int id, String title) {
        return base(id, title, "Item sem dados pessoais")
                .setGroup(GROUP_KEY)
                .setGroupAlertBehavior(Notification.GROUP_ALERT_SUMMARY)
                .addAction(android.R.drawable.ic_menu_view, "Ação de teste", actionPendingIntent(id))
                .build();
    }

    private PendingIntent actionPendingIntent(int requestCode) {
        Intent intent = new Intent(this, ProbeActionReceiver.class)
                .setAction("dev.killnotify.probe.SYNTHETIC_ACTION")
                .putExtra("probe_version", requestCode);
        return PendingIntent.getBroadcast(this, requestCode, intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
    }

    private Notification.Builder base(int id, String title, String text) {
        PendingIntent contentIntent = PendingIntent.getActivity(this, 700 + id,
                new Intent(this, ProbeActivity.class),
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        return new Notification.Builder(this, CHANNEL_ID)
                .setSmallIcon(android.R.drawable.ic_dialog_info)
                .setContentTitle(title)
                .setContentText(text)
                .setContentIntent(contentIntent)
                .setAutoCancel(true)
                .setWhen(System.currentTimeMillis());
    }

    private void cancelAll() {
        notifications.cancelAll();
    }

    private LinearLayout.LayoutParams matchWrap() {
        return new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
    }
}
